FROM registry.cn-hangzhou.aliyuncs.com/bewithmeallmylife/11.4.0-cudnn8-runtime-ubuntu18.04-conda-python3.8-qt5:1.0.0

USER root
ENV PATH /root/anaconda3/bin:$PATH
RUN  conda create -n mini-omni2 python=3.10 -y
SHELL ["conda", "run", "-n", "mini-omni2", "/bin/bash", "-c"]
ENV LANGUAGE zh_CN:zh


RUN pip install torch==2.2.0  -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install torchvision==0.17.0  -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install torchaudio==2.2.1 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install litgpt==0.4.3 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install snac==1.2.0 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install soundfile==0.12.1 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install openai-whisper -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install tokenizers==0.19.1  -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install streamlit==1.37.1 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install streamlit-webrtc -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install  PyAudio==0.2.14 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install pydub==0.25.1 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install onnxruntime==1.19.0 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
# numpy==1.26.3
RUN pip install librosa==0.10.2.post1 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install flask==3.0.3 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install fire -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com

RUN pip instal gradio_webrtc[vad]==0.0.11 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip instaltwilio -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN git+https://github.com/mini-omni/CLIP.git
WORKDIR /app/mini-omni2

COPY *.py  /app/mini-omni2

ADD litgpt litgpt
ADD utils utils
ADD webui webui

ENV HF_ENDPOINT https://hf-mirror.com
ENV HF_HOME /hugging_face_home

CMD ["/root/anaconda3/envs/mini-omni2/bin/python","API_URL=http://0.0.0.0:60808/chat streamlit run webui/omni_streamlit.py"]

#sudo docker build -t='registry.cn-hangzhou.aliyuncs.com/bewithmeallmylife/mini-omni2-cuda-11.4.0:1.0.0' .

#sudo docker run   --ipc=host   --privileged  -p 5112:5112 -it -d  registry.cn-hangzhou.aliyuncs.com/bewithmeallmylife/bill-customer-risk-detect-api-cuda-11.4.0:1.0.0
