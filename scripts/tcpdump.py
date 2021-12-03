import sh 
import os 

def main():
    #docker run --rm --net=host 
    # -v $PWD/tcpdump:/tcpdump 
    # kaazing/tcpdump
    sh.docker.run(
        '--rm', '-d',
        '--net=host',
        '-v $PWD/tcpdump:/tcpdump',
        'kaazing/tcpdump'
    )

if __name__ == "__main__":
    main()