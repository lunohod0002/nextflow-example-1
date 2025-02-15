process hello {
    container 'ubuntu:latest'
    debug true
    
    """
    cowsay Hello Summit!!! 
    """
}
