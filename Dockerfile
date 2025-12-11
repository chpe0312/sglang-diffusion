FROM lmsysorg/sglang:nightly-dev-20251202-1da59e83

# Bash als Shell, damit wir Bedingungen/&& sauber nutzen können
SHELL ["/bin/bash", "-lc"]

# OpenShift-tauglicher Cache-Pfad (nicht /root, weil random UID -> nicht schreibbar)
ENV HF_HOME=/cache/huggingface \
    TRANSFORMERS_CACHE=/cache/huggingface \
    HF_HUB_ENABLE_HF_TRANSFER=1

# Cache-Verzeichnis anlegen + Rechte so setzen, dass OpenShift "random UID" schreiben darf
RUN mkdir -p /cache/huggingface && \
    chgrp -R 0 /cache && \
    chmod -R g=u /cache

# Dependencies zur Build-Zeit installieren (nicht beim Containerstart)
RUN python -m pip install -U pip && \
    if [[ -d "/sgl-workspace/sglang/python" ]]; then \
      python -m pip install --no-cache-dir -e "/sgl-workspace/sglang/python[diffusion]"; \
    else \
      python -m pip install --no-cache-dir -U "sglang[diffusion]"; \
    fi && \
    python -m pip install --no-cache-dir -U hf_transfer

EXPOSE 3000

# Wichtig: ENTRYPOINT fix, CMD sind Default-Args und können in OpenShift überschrieben werden
ENTRYPOINT ["sglang", "serve"]
CMD ["--model-path", "Tongyi-MAI/Z-Image-Turbo", "--host", "0.0.0.0", "--port", "3000", "--num-gpus", "1"]
