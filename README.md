### Run

### Kubernetes

```bash
$ nextflow kuberun https://github.com/Mirocow/nextflow-example-1 -r main -head-image 'nextflow/nextflow:22.10.8' -v n
extflow-pvc:/mnt -profile kubernetes --outdir /tmp
```

### Docker

```bash
$ nextflow run main.nf -profile docker --outdir /tmp
```
