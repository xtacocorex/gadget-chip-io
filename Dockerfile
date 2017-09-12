FROM xtacocorex/gadget-chip-dt-overlays as build

# ALPINE LINUX ARM WOOO!
FROM arm32v6/alpine

COPY --from=build /lib/firmware/nextthingco /lib/firmware/nextthingco

# Install tools needed to download and build the CHIP_IO library from source.
RUN apk update && \
        apk add python py-setuptools && \
        apk add --no-cache --virtual=temporary make gcc g++ flex bison git python-dev && \
        # Download the latest CHIP_IO source code
        git clone https://github.com/xtacocorex/CHIP_IO.git && \
        # Install the CHIP_IO library from the proper directory
        cd CHIP_IO && python setup.py install && \
        # Remove CHIP_IO source code directory after it has been installed
        cd ../ && rm -rf CHIP_IO && \
        # Remove build tools, which are no longer needed after installation
        apk del temporary && \
        rm -rf /var/cache/apk/*
