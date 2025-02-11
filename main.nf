#!/usr/bin/env nextflow

include { hello } from './module'

workflow {
    hello()
}
