from typing import Union

from fastapi import FastAPI
from pydantic import BaseModel
import openai
import re

app = FastAPI()


OPENAI_YOUR_KEY = "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"
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
              ["구개음화가 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분도 표시해줘 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘",
               "두음법칙이 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분도 표시해줘 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘",
               "치조마찰음화가 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분도 표시해줘 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘",
               "ㄴ첨가가 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분도 표시해줘 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘",
               "ㄹ첨가가 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분도 표시해줘 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘",
               "단모음화가 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분도 표시해줘 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘",
               "모음조화가 이루어지는 문장 하나와 그걸 읽는 적정속도도 초로 말해줘 그리고 중간에 숨을쉬어야하는 부분은 (숨)을 표시해서 알려줘 그리고 다른 부연설명하지말고 문장과 중간에 숨을 쉬어야 하는 부분 그리고 읽는 적정속도도 초만 말해줘"],
               ["",
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
    answerSpeed = re.findall(r'\d+', response.choices[0].message.content)
    returnArray = [values,answerSpeed]
    return returnArray

@app.get("/")
async def root():
    return {"message": "Hello world"}
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
    values = re.findall(r'"([^"]+)"',response.choices[0].message.content)
    breath = response.choices[0].message.content
    answerSpeed = re.findall(r'\d+', response.choices[0].message.content)
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
    values = re.findall(r'"([^"]+)"',response.choices[0].message.content)
    breath = response.choices[0].message.content
    answerSpeed = re.findall(r'\d+', response.choices[0].message.content)
    returnArray = [values,breath,answerSpeed]
    return returnArray

@app.get("/get-paragraph")
async def get_paragraph():
    ResultText = chatGptSentence(inputText[1][0])
    sentence = ResultText[0]
    breath = ResultText[1]
    answerSpeed = ResultText[2]
    index = 1
    return {"sentence": sentence, "breath": breath, "answerSpeed": answerSpeed, "index": index}



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