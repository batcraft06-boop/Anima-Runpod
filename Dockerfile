FROM runpod/worker-comfyui:5.8.4-base

# Models
RUN comfy model download --url https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/text_encoders/qwen_3_06b_base.safetensors --relative-path models/text_encoders --filename qwen_3_06b_base.safetensors
RUN comfy model download --url https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/vae/qwen_image_vae.safetensors --relative-path models/vae --filename qwen_image_vae.safetensors
RUN comfy model download --url https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/diffusion_models/anima-preview2.safetensors --relative-path models/diffusion_models --filename anima-preview2.safetensors

# Turbo LoRA — replace YOUR_CIVITAI_TOKEN
RUN comfy model download --url "https://civitai.com/api/download/models/2877687?token=YOUR_CIVITAI_TOKEN" --relative-path models/loras --filename anima_turbo.safetensors

# rgthree custom nodes
RUN comfy node install rgthree-comfy
