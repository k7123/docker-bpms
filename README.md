# docker-bpms

Simple docker image to handle my BPMS build. This is by no means a production grade image, it's there to get something up fast. If you want help with Red Hat BPM Suite and Docker in production environment, [contact Red Hat Consulting](https://www.redhat.com/en/services/consulting/business-automation).

Built on [my base EAP image](https://hub.docker.com/r/sherl0cks/docker-eap/). Master will always reflect the latest GA release.

## Users for Business Central / Kie-Server
There is a provided default user, jboss, with password bpmsuite1!

## Githook Support & Cloning Git Repos SSH Keys

As BxMS 6.2.2, it is possible to clone a [git repo into Business Central using an SCP style urls](https://bugzilla.redhat.com/show_bug.cgi?id=1299619), which is crucial for [using githooks](https://bugzilla.redhat.com/show_bug.cgi?id=1066962), which have been available since 6.2.0. This container supports this feature, you just nee to mount a volume with the relevant ssh key. Here's an example:
`sudo docker run -itP -v ~/DockerVolumes/ssh:/opt/jboss/.ssh:Z sherl0cks/docker-bpms:6.3.0.ER1`
