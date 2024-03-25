FROM debian:trixie-slim
ARG VERSION
RUN \
    apt-get update -y \
    && apt-get install -y libnspr4 libnss3 libexpat1 libfontconfig1 libuuid1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY \
    out/amd64/$VERSION/headless-shell/headless-shell \
    out/amd64/$VERSION/headless-shell/.stamp \
    out/amd64/$VERSION/headless-shell/libEGL.so \
    out/amd64/$VERSION/headless-shell/libGLESv2.so \
    out/amd64/$VERSION/headless-shell/libvk_swiftshader.so \
    out/amd64/$VERSION/headless-shell/libvulkan.so.1 \
    out/amd64/$VERSION/headless-shell/vk_swiftshader_icd.json \
    /headless-shell/
EXPOSE 9222
ENV LANG en-US.UTF-8
ENV PATH /headless-shell:$PATH
ENTRYPOINT [ "/headless-shell/headless-shell", "--no-sandbox", "--use-gl=angle", "--use-angle=swiftshader", "--remote-debugging-address=0.0.0.0", "--remote-debugging-port=9222" ]
