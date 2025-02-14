process hello {
    container 'ubuntu:20.04'
    debug true
    
    """
    cowsay Hello Summit!!! 
    """
}
