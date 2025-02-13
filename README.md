### Запуск Nextflow с помощью Kubernetes

### Проблема: при запуске Nextflow pipeline с помощью Kubernetes возникает ошибка "Process terminated for an unknown reason"
### Настройки запуска:
Для успешного запуска необходимо создать Persistent Volume Claime (PVC) с правами ReadWriteMany и указать Storage Class с RWX правами. Также необходимо создать сервсиный аккаунт в одном namespace с PVC.
### nextflow.config файл
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

### Запуск

### Kubernetes

```bash
$ nextflow kuberun <GIT-URL> -r main -v nextflow-pvc:/mnt -profile kubernetes --outdir /tmp
```


