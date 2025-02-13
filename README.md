### Запуск Nextflow с помощью Kubernetes

### Проблема: при запуске Nextflow pipeline с помощью Kubernetes возникает ошибка "Process terminated for an unknown reason"
### Настройки запуска:
Настройки kubernetes:  
Для успешного запуска необходимо создать Persistent Volume Claime (PVC) с режимом доступа ReadWriteMany и указать Storage Class с RWX правами. Также необходимо создать сервсиный аккаунт в одном namespace с PVC.
### nextflow-pvc.yaml
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nextflow-pvc
  namespace: nextflow
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 20Gi
  storageClassName: nfs-rwx
```
### nfs-rwx-storageclass.yaml

```
allowVolumeExpansion: true
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  annotations:
    meta.helm.sh/release-name: nfs-provisioner
    meta.helm.sh/release-namespace: default
  creationTimestamp: "2025-02-06T08:25:50Z"
  labels:
    app: nfs-subdir-external-provisioner
    app.kubernetes.io/managed-by: Helm
    chart: nfs-subdir-external-provisioner-4.0.18
    heritage: Helm
    release: nfs-provisioner
  name: nfs-rwx
  resourceVersion: "7814"
  uid: 527ce739-9533-4ba0-ad94-042dc30712e3
parameters:
  archiveOnDelete: "true"
provisioner: cluster.local/nfs-provisioner-nfs-subdir-external-provisioner
reclaimPolicy: Delete
volumeBindingMode: Immediate
```
### nextflow.config
```
process {
    executor = 'k8s'
}
wave {
    enabled = false
}
fusion {
    enabled = false
    privileged = false
}
k8s {
    debug {
     yaml = true
    }
    serviceAccount = 'nextflow-sa'
    namespace = 'nextflow'
    storageClaimName = 'nextflow-pvc'
    podVolume = 'nextflow-pvc:/mnt/nfs_workdir'  
}
```
### Запуск

### Kubernetes

```bash
$ nextflow kuberun <GIT-URL> -r main -v nextflow-pvc:/mnt -profile kubernetes --outdir /tmp
```


