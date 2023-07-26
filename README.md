WAF-Ambro is a project started from [ModSecurity-nginx](https://github.com/SpiderLabs/ModSecurity-nginx). Ambrosia-Tech uses this project in differents cloud internal deployment services. In some cases to protect CD/CI pipelines with very strict rules, working similar to WAF-API like protections.

This repo will integrate some changes and automation internaly used.

Creating a WAF-Ambro container:

> cd build/building-container
>
> ./buildWAFAmbro.sh

## Auto rule update

Production rules are automatically added when containers are created

## References:

https://github.com/coreruleset/modsecurity-crs-docker
