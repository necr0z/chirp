import os
import sh

def main():
    for i in range(10):
        sh.docker.run('-d', '--rm',
            '--name', f'chirpscript-{i}',
            '--network', 'chirp_postgres',
            'chirpscript'
        )

if __name__ == "__main__":
    main()