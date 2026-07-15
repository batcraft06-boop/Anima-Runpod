# syntax=docker/dockerfile:1.7

FROM runpod/worker-comfyui:5.8.5-base

# Megumin's workflow calls this repository-local node to turn the supplied
# roleplay scene into the final positive prompt.
COPY comfyui_custom_nodes/ComfyUI-Megumin-NanoGPT /comfyui/custom_nodes/ComfyUI-Megumin-NanoGPT

# Anima Turbo requires its Qwen text encoder and VAE in addition to the
# diffusion model. No other checkpoints or LoRAs are baked into this image.
RUN comfy model download \
  --url https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/diffusion_models/anima-turbo-v1.0.safetensors \
  --relative-path models/diffusion_models \
  --filename anima-turbo-v1.0.safetensors

RUN comfy model download \
  --url https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/text_encoders/qwen_3_06b_base.safetensors \
  --relative-path models/text_encoders \
  --filename qwen_3_06b_base.safetensors

RUN comfy model download \
  --url https://huggingface.co/circlestone-labs/Anima/resolve/main/split_files/vae/qwen_image_vae.safetensors \
  --relative-path models/vae \
  --filename qwen_image_vae.safetensors
