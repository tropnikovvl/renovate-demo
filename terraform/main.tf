locals {
  helm_releases = {
    velero = {
      version    = "10.1.3"
      chart      = "velero"
      repository = "https://vmware-tanzu.github.io/helm-charts"
      values = [
        <<-EOT
        initContainers:
          - name: velero-plugin-for-aws
            image: velero/velero-plugin-for-aws:v1.12.1 # renovate: datasource=github-releases depName=velero/velero-plugin-for-aws
            imagePullPolicy: IfNotPresent
            volumeMounts:
              - mountPath: /target
                name: plugins
        EOT
      ]
    }
  }
}
