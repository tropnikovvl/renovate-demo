import subprocess
from pathlib import Path

import yaml

changed_files = subprocess.check_output(["git", "diff", "--name-only"]).decode().strip().split("\n")
helmfile_files = [f for f in changed_files if f.endswith("helmfile.yaml")]
dir = "helm-values"

Path(dir).mkdir(parents=True, exist_ok=True)

for file in helmfile_files:
    with open(file) as f:
        helmfile_docs = yaml.safe_load_all(f)
        releases = []
        repositories = []

        for helmfile in helmfile_docs:
            helm_releases = helmfile.get("releases", [])
            releases.extend([r for r in helm_releases if r.get("version") is not None])
            print(releases)

            helm_repositories = helmfile.get("repositories", [])
            repositories.extend(helm_repositories)
            print(repositories)

        for repo in repositories:
            name = repo.get("name")
            url = repo.get("url")
            subprocess.run(f"helm repo add {name} {url}", shell=True, executable="/bin/bash")

        subprocess.run(f"helm repo update", shell=True, executable="/bin/bash")

        for release in releases:
            name = release.get("name")
            chart = release.get("chart")
            version = release.get("version")
            subprocess.run(
                f"helm show values {chart} --version {version} > {dir}/{name}.yaml",
                shell=True,
                executable="/bin/bash",
            )
