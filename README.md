# Pocketbase image based on Unikraft

*Note*: Due to a bug in Unikraft, runtime needs to be set to `base-compat:latest`, instead of `base:latest`. This might change later.

Currently, the server does not scale down to 0, can be configured to do so if required by setting the following labels in `kraftfile`:

```yaml

labels:
  cloud.unikraft.v1.instances/scale_to_zero.policy: "on"
  cloud.unikraft.v1.instances/scale_to_zero.cooldown_time_ms: 1000

```
## Development

Before building docker image and kraft image please clone pcoket base to root directory first. (https://github.com/pocketbase/pocketbase.git)
