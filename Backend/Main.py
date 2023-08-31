from typing import Union

from fastapi import FastAPI, File
from starlette.responses import JSONResponse


import io
import asyncio
# 유사도 분석 import
import difflib

import whisper

from pydantic import BaseModel
import openai
import re

app = FastAPI()


OPENAI_YOUR_KEY = ""
openai.api_key = OPENAI_YOUR_KEY
index = 0
breathSentences = []
#1단계: 단어, 2단계 문장, 3단계 지문
#종류, 구개음화,두음법칙,치조마찰음화,ㄴ첨가,ㄹ첨가,단모음화,모음조화

# TODO: 질문 정해서 입력받기, 그리고 입력 초도 답변으로 받아서 분리하기 단어 말할떄랑 문장으로 말할떄 post get 분리하기
inputText = [["구개음화가 이루어지는 단어 하나와 그걸 읽는 적정 속도도 초로 말해줘 다른 말은 하지마 부연설명도 하지말고 단어와 적정속도만 딱 말해줘",
              "두음법칙이 이루어지는 단어 하나와 그걸 읽는 적정 속도도 초로 말해줘 다른 말은 하지마 부연설명도 하지말고 단어와 적정속도만 딱 말해줘",
              "치조마찰음화가 이루어지는 단어 하나와 그걸 읽는 적정 속도도 초로 말해줘 다른 말은 하지마 부연설명도 하지말고 단어와 적정속도만 딱 말해줘",
              "ㄴ첨가가 이루어지는 단어 하나와 그걸 읽는 적정 속도도 초로 말해줘 다른 말은 하지마 부연설명도 하지말고 단어와 적정속도만 딱 말해줘",
              "ㄹ첨가가 이루어지는 단어 하나와 그걸 읽는 적정 속도도 초로 말해줘 다른 말은 하지마 부연설명도 하지말고 단어와 적정속도만 딱 말해줘",
              "단모음화가 이루어지는 단어 하나와 그걸 읽는 적정 속도도 초로 말해줘 다른 말은 하지마 부연설명도 하지말고 단어와 적정속도만 딱 말해줘",
              "모음조화가 이루어지는 단어 하나와 그걸 읽는 적정 속도도 초로 말해줘 다른 말은 하지마 부연설명도 하지말고 단어와 적정속도만 딱 말해줘"],
              ["구개음화가 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분은 (숨)을 표시해서 알려줘 그리고 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘. 말해줄 때 다음과 같은 구조로 대답해줘 문장:\"\" \n 숨쉬는 위치: \"\"\n 적정 속도: \"\"\n",
               "두음법칙이 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분은 (숨)을 표시해서 알려줘 그리고 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘. 말해줄 때 다음과 같은 구조로 대답해줘 문장:\"\" \n 숨쉬는 위치: \"\"\n 적정 속도: \"\"\n",
               "치조마찰음화가 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분은 (숨)을 표시해서 알려줘 그리고 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘. 말해줄 때 다음과 같은 구조로 대답해줘 문장:\"\" \n 숨쉬는 위치: \"\"\n 적정 속도: \"\"\n",
               "ㄴ첨가가 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분은 (숨)을 표시해서 알려줘 그리고 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘. 말해줄 때 다음과 같은 구조로 대답해줘 문장:\"\" \n 숨쉬는 위치: \"\"\n 적정 속도: \"\"\n",
               "ㄹ첨가가 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분은 (숨)을 표시해서 알려줘 그리고 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘. 말해줄 때 다음과 같은 구조로 대답해줘 문장:\"\" \n 숨쉬는 위치: \"\"\n 적정 속도: \"\"\n",
               "단모음화가 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분은 (숨)을 표시해서 알려줘 그리고 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘. 말해줄 때 다음과 같은 구조로 대답해줘 문장:\"\" \n 숨쉬는 위치: \"\"\n 적정 속도: \"\"\n",
               "모음조화가 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분은 (숨)을 표시해서 알려줘 그리고 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘. 말해줄 때 다음과 같은 구조로 대답해줘 문장:\"\" \n 숨쉬는 위치: \"\"\n 적정 속도: \"\"\n"],
               ["구개음화가 이루어지는 문장 7개가 포함된 문단 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을 쉬어야하는 부분은 (숨)을 표시해서 알려줘 문장 내부에서도 숨을 쉬어야 하는 부분이 있다면 (숨)으로 표시해줘 그리고 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 문장별로 몇 초씩인지 초만 말해줘. 말해줄 때 다음과 같은 구조로 대답해줘 문단:\"\" \n 숨쉬는 위치: \"\"\n 적정 속도: \"\"\n",
                "",
                "",
                "",
                "",
                "",
                ""]
                ]

MODEL = "gpt-4"
USER_INPUT_MSG = "구개음화가 이루어지는 문단을 출력해줘 문단만 출력해 부가설명은 생략하고"


# 단어 chatgpt값을 불러오는 함수
def chatGptWord(input):
    USER_INPUT_MSG = input
    response = openai.ChatCompletion.create(
    model = MODEL,
    messages = [
        {"role": "system", "content": "You are a helpful assistant"},
        {"role": "user","content" : USER_INPUT_MSG},
        {"role" : "assistant", "content": "who's there"},
    ],
    temperature = 1,
    )
    values = re.findall(r'"([^"]+)"',response.choices[0].message.content)
    values = values[0]
    answerSpeed = re.findall(r'\d+', response.choices[0].message.content)
    answerSpeed = float(answerSpeed[0])
    returnArray = [values,answerSpeed]
    return returnArray

# 단어
@app.get("/get-word")
async def get_word():
    ResultText = chatGptWord(inputText[0][1])
    wordName = ResultText[0]
    wordSpeed = ResultText[1]
    index = 1
    print(wordName,wordSpeed)
    return {"wordName": wordName, "wordSpeed": wordSpeed,"index": index}

# 문장
def chatGptSentence(input):
    USER_INPUT_MSG = input
    response = openai.ChatCompletion.create(
    model = MODEL,
    messages = [
        {"role": "system", "content": "You are a helpful assistant"},
        {"role": "user","content" : USER_INPUT_MSG},
        {"role" : "assistant", "content": "who's there"},
    ],
    temperature = 1,
    )
    print(response.choices[0].message.content)
    values = re.findall(r'"([^"]+)"',response.choices[0].message.content)
    values = values[0].replace('(숨)', ' ')
    values = ' '.join(values.split())
    #숨 쉴 부분 반환
    # breath = response.choices[0].message.content
    breath = re.findall(r'"([^"]+)"',response.choices[0].message.content)
    # print(breath)
    if len(breath) == 1:
        breath = breath[0].split('(숨)')
    else:
        breath = breath[1].split('(숨)')
    
    for i in range(len(breath)):
            breath[i] = breath[i].strip()
    
    answerSpeed = re.findall(r'\d+', response.choices[0].message.content)
    answerSpeed = float(answerSpeed[0])
    returnArray = [values,breath,answerSpeed]
    return returnArray

@app.get("/get-sentence")
async def get_sentence():
    ResultText = chatGptSentence(inputText[1][0])
    sentence = ResultText[0]
    breath = ResultText[1]
    answerSpeed = ResultText[2]
    index = 1
    return {"sentence": sentence, "breath": breath, "answerSpeed": answerSpeed, "index": index}

# 문단
def chatGptParagraph(input):
    USER_INPUT_MSG = input
    response = openai.ChatCompletion.create(
    model = MODEL,
    messages = [
        {"role": "system", "content": "You are a helpful assistant"},
        {"role": "user","content" : USER_INPUT_MSG},
        {"role" : "assistant", "content": "who's there"},
    ],
    temperature = 1,
    )
    print(response.choices[0].message.content)
    values = re.findall(r'"([^"]+)"',response.choices[0].message.content)
    values = values[0].replace('(숨)', ' ')
    values = ' '.join(values.split())
    values = values.split('.')
    for i in range(len(values)):
        values[i] = values[i].strip()
        values[i] = values[i]+'.'
    
    del values[-1]
    #숨 쉴 부분 반환
    breath = re.findall(r'"([^"]+)"',response.choices[0].message.content)
   
    breath = breath[0].replace('(숨)', '*')
    breath = breath.replace('.','.*')
    breath = breath.replace('!','!*')
    breath = breath.replace('?','?*')

    breath = breath.replace('**', '*')

    breath = re.split(r'[\*]', breath)
    del breath[-1]
    breath = list(filter(None, breath))
    print(breath)
    
    for i in range(len(breath)):
        breath[i] = breath[i].strip()
    
    answerSpeed = re.findall(r'\d+', response.choices[0].message.content)
    print(answerSpeed)
    answerSpeed = float(answerSpeed[0])
    returnArray = [values,breath,answerSpeed]
    return returnArray

@app.get("/get-paragraph")
async def get_paragraph():
    ResultText = chatGptParagraph(inputText[2][0])
    sentence = ResultText[0]
    breath = ResultText[1]
    answerSpeed = ResultText[2]
    index = 1
    return {"sentence": sentence, "breath": breath, "answerSpeed": answerSpeed, "index": index}

@app.post('/check/sentence')
async def check_sentence(origin_str: str, file: bytes = File()):
    with open('audio.mp3', 'wb') as f:
        f.write(file)
    
    # 반환할 값들을 저장하는 딕셔너리
    res = {}
    # 숨 쉬는 부분을 나누어 저장하는 리스트
    breaths = []
    # 문장을 읽는데 걸리는 시간
    time = 0
    # 원본 문장에서 차이가 나는 idx를 저장하는 리스트
    origin_idx = []
    # 비교할 문장에서 원본 문장과 차이가 나는 idx를 저장하는 리스트
    compared_idx = []

    # whisper 음성 파일을 기반으로 STT 처리
    model = whisper.load_model("base")

    result = model.transcribe("audio.mp3")

    # 연습 단어/문장과 실제로 말한 단어/문장을 비교하여 유사도 계산하기
    compared_str = result['text'].lstrip()

    res['text'] = compared_str.lstrip()

    # print("result: ", result)
    # print("compared str: ", compared_str)

    answer_bytes = bytes(origin_str, 'utf-8')
    input_bytes = bytes(compared_str, 'utf-8')
    answer_bytes_list = list(answer_bytes)
    input_bytes_list = list(input_bytes)

    sm = difflib.SequenceMatcher(None, answer_bytes_list, input_bytes_list)
    similar = sm.ratio()

    for i in result['segments']:
        breaths.append(i['text'])

    res['breaths'] = breaths

    for i in result['segments']:
        time += (i['end'] - i['start'])

    res['time'] = time

    # 비교를 위한 Differ 객체 생성
    differ = difflib.Differ()

    # 두 문장을 비교하고 차이를 출력
    diff = list(differ.compare(origin_str, compared_str))

    # 차이 출력
    for idx, line in enumerate(diff):
        if line[0] != " ":
            if line[0] == "+":
                compared_idx.append(idx - len(origin_idx))
            else:
                origin_idx.append(idx - len(compared_idx))

    res['similarity'] = similar
    res['compared_idx'] = compared_idx
    res['origin_idx'] = origin_idx
    
    return JSONResponse(res)
    

@app.post('/check/word')
async def check_word(origin_str: str, file: bytes = File()):
    with open('audio.mp3', 'wb') as f:
        f.write(file)
    
    # 반환할 값들을 저장하는 딕셔너리
    res = {}
    # 단어를 읽는데 걸리는 시간
    time = 0
    # 원본 단어에서 차이가 나는 idx를 저장하는 리스트
    origin_idx = []
    # 비교할 단어에서 원본 단어와 차이가 나는 idx를 저장하는 리스트
    compared_idx = []

    # whisper 음성 파일을 기반으로 STT 처리
    model = whisper.load_model("base")

    result = model.transcribe("audio.mp3")

    # 연습 단어/문장과 실제로 말한 단어/문장을 비교하여 유사도 계산하기
    compared_str = result['text'].lstrip()

    res['text'] = compared_str.lstrip()

    # print("result: ", result)
    # print("compared str: ", compared_str)

    answer_bytes = bytes(origin_str, 'utf-8')
    input_bytes = bytes(compared_str, 'utf-8')
    answer_bytes_list = list(answer_bytes)
    input_bytes_list = list(input_bytes)

    sm = difflib.SequenceMatcher(None, answer_bytes_list, input_bytes_list)
    similar = sm.ratio()

    for i in result['segments']:
        time += (i['end'] - i['start'])

    res['time'] = time

    # 비교를 위한 Differ 객체 생성
    differ = difflib.Differ()

    # 두 문장을 비교하고 차이를 출력
    diff = list(differ.compare(origin_str, compared_str))

    # 차이 출력
    for idx, line in enumerate(diff):
        if line[0] != " ":
            if line[0] == "+":
                compared_idx.append(idx - len(origin_idx))
            else:
                origin_idx.append(idx - len(compared_idx))

    res['similarity'] = similar
    res['compared_idx'] = compared_idx
    res['origin_idx'] = origin_idx
    
    return JSONResponse(res)


# TODO: 적정속도 파싱해서 변수에 넣기 온점 물음표 느낌표

##
# ResultText =re.sub(r"[^ㄱ-ㅣ가-힣\s]", "", response.choices[0].message.content)
# print(response.choices[0].message.content)

# # 단어와 적정 속도만 추출
# values = re.findall(r'"([^"]+)"',response.choices[0].message.content)
# answerSpeed = re.findall(r'\d+', response.choices[0].message.content)


# 문장의 적정 속도와 숨부분 추출
# ResultSentenceText = response.choices[0].message.content 
# breathSentence = ResultSentenceText.split('.')
# for i in breathSentence:
#     breathSentences.append(i)

# print(breathSentences)

# TODO: 
# 단어일때 보내는 것
# 단어와 적정 속도
# 문장일때 보내는 것
# 문장, 문장읽는 속도, 문장 숨쉬는 부분(배열로 보낸다.)
# 지문일때 보내는 것
# 문장배열로, 통지문 읽는 속도, 문장 숨쉬는 부분[이차원 배열]