# sglang-diffusion


Use in Openshift like:

containers:
#- name: sglang-z-image-turbo
#  image: ....
#  imagePullPolicy: IfNotPresent
#  command: ["sglang", "serve"]
#  args:
#    - --model-path=Tongyi-MAI/Z-Image-Turbo
#    - --host=0.0.0.0
#    - --port=3000
#    - --num-gpus=1
#  env:
#    - name: HF_HOME
#      value: /cache/huggingface
#    - name: TRANSFORMERS_CACHE
#      value: /cache/huggingface
#    - name: HF_HUB_ENABLE_HF_TRANSFER
#      value: "1"
#  ports:
#    - containerPort: 3000
