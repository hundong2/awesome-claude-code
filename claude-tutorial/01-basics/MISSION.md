# 01단계 미션

> 각 미션을 완료하면 PRACTICE.md에 결과를 기록하세요

---

## 미션 1: 첫 접촉 ⭐

**목표**: Claude Code가 제대로 설치되어 있는지 확인하고 첫 대화를 나눈다

**할 일**:
```bash
claude --version
claude -p "안녕! 오늘 날짜와 현재 디렉토리를 알려줘"
```

**성공 기준**: 버전 번호 출력 + 응답 받기

---

## 미션 2: 파이프라인 마법 ⭐⭐

**목표**: 파이프(`|`)를 사용해서 Claude를 다른 명령어와 연결한다

**할 일**:
```bash
# 이 tutorial 폴더의 구조를 Claude에게 분석시키기
ls -la | claude -p "이 파일 목록을 보고 어떤 프로젝트인지 추측해줘"

# 현재 git 상태를 Claude에게 요약시키기
git status | claude -p "이 git 상태를 한국어로 요약해줘"
```

**성공 기준**: Claude가 파이프로 받은 내용을 분석해서 응답

---

## 미션 3: JSON 출력 마스터 ⭐⭐

**목표**: JSON 출력 형식을 사용해서 스크립팅에 활용할 수 있는 출력 만들기

**할 일**:
```bash
claude -p "Python, JavaScript, Go 각 언어의 장점을 JSON 배열로 알려줘" \
  --output-format json

# stream-json으로 스트리밍 확인
claude -p "숫자 1부터 5까지 설명해줘" --output-format stream-json
```

**성공 기준**: JSON 형식의 출력 확인

---

## 미션 4: 세션 이어하기 ⭐⭐⭐

**목표**: 세션을 저장하고 나중에 이어서 대화를 계속할 수 있다

**할 일**:
1. `claude` 실행 후 인터랙티브 모드 진입
2. "내가 좋아하는 과일은 사과야" 라고 입력
3. `/rename fruit-test` 로 세션 이름 지정
4. `Ctrl+D` 로 종료
5. `claude -r "fruit-test"` 로 다시 연결
6. "내가 아까 뭐가 좋다고 했지?" 라고 물어보기

**성공 기준**: Claude가 이전 대화 내용(사과)을 기억하고 답변

---

## 미션 5: 권한 모드 실험 ⭐⭐⭐

**목표**: 다른 권한 모드에서 Claude의 동작 차이를 이해한다

**할 일**:
```bash
# Plan 모드 (읽기만 가능)
claude --permission-mode plan
# → 인터랙티브 모드에서 "test.txt 파일을 만들어줘" 요청
# → Claude가 실행하지 않고 계획만 세우는지 확인

# acceptEdits 모드 (파일 편집 자동 승인)
claude --permission-mode acceptEdits
# → "hello.txt 파일에 '안녕하세요'를 써줘" 요청
# → 승인 없이 파일이 생성되는지 확인
```

**성공 기준**: 각 모드의 동작 차이를 직접 경험

---

## 미션 6: 도전 과제 ⭐⭐⭐⭐

**목표**: 실제 개발 시나리오에서 Claude를 활용한다

**시나리오**: 이 `claude-tutorial` 폴더의 코드를 분석해달라고 요청하기

```bash
claude -p "claude-tutorial 폴더의 구조를 분석하고,
개선할 수 있는 점 3가지를 한국어로 알려줘"
```

**성공 기준**: Claude가 폴더 구조를 실제로 읽고 구체적인 개선안 제시

---

## 완료 체크리스트

모든 미션 완료 후 PRACTICE.md에 다음을 기록하세요:
- [ ] 가장 놀랐던 점
- [ ] 가장 유용하다고 생각한 기능
- [ ] 다음 단계에서 알고 싶은 것
