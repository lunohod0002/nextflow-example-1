process hello {
    container 'ubuntu:22.04'
    debug true
    
    """
    cowsay Hello Summit!!! 
    """
}
