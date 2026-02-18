# 02단계 미션

---

## 미션 1: 슬래시 명령어 탐험 ⭐

`claude`를 실행하고 아래 명령어를 순서대로 입력하세요:

```
/help
/status
/cost
```

**기록할 것**: `/status`에서 확인되는 모델 이름을 PRACTICE.md에 기록

---

## 미션 2: 컨텍스트 시각화 ⭐⭐

1. `claude` 실행
2. 아래 긴 텍스트를 입력해서 컨텍스트를 채우기:
   ```
   Python, JavaScript, Go, Rust, Java, C++, TypeScript, Ruby, PHP, Swift,
   Kotlin, Scala, Haskell, Erlang, Elixir, Clojure, F#, OCaml, Nim, Zig
   각 언어의 특징을 2~3문장씩 설명해줘
   ```
3. 응답 받은 후 `/context` 입력해서 사용량 확인
4. `/compact` 로 압축
5. `/context` 다시 확인 → 변화 관찰

**기록할 것**: 압축 전/후 컨텍스트 사용량 차이

---

## 미션 3: 대화 중 모델 변경 ⭐⭐

1. `claude` 실행
2. "지금 어떤 모델이야?" 질문
3. `/model` 입력해서 모델 변경 UI 열기
4. 다른 모델 선택 (예: haiku)
5. "지금 어떤 모델이야?" 다시 질문
6. 차이 확인

---

## 미션 4: 권한 모드 토글 ⭐⭐

1. `claude` 실행 (기본 default 모드)
2. 하단 상태바의 모드 확인
3. `Shift+Tab` 을 눌러서 모드 순환:
   - default → acceptEdits → plan → default
4. 각 모드에서 "test.txt 파일에 '테스트' 라고 써줘" 요청
5. 모드마다 동작이 어떻게 다른지 관찰

---

## 미션 5: 파일 참조 마스터 ⭐⭐⭐

1. `claude` 실행
2. `@` 를 입력하고 탭 키로 자동완성 탐색
3. 이 튜토리얼의 README.md를 참조해서 요약 요청:
   ```
   @README.md 이 파일의 핵심 내용을 3줄로 요약해줘
   ```
4. 두 개 파일 동시 참조:
   ```
   @01-basics/README.md @02-interactive/README.md
   두 단계의 차이점을 표로 정리해줘
   ```

---

## 미션 6: Rewind (되감기) ⭐⭐⭐

1. `claude` 실행
2. "내가 좋아하는 색은 빨간색이야"
3. "내가 좋아하는 동물은 고양이야"
4. "내 취미는 독서야"
5. `Esc+Esc` 두 번 눌러서 rewind
6. 어느 메시지로 돌아갔는지 확인

**이것이 유용한 이유**: 잘못된 방향으로 간 대화를 취소하고 다시 시작할 수 있음

---

## 미션 7: 도전 - 세션 내보내기 ⭐⭐⭐⭐

1. `claude` 실행
2. 흥미로운 주제로 5번 이상 대화 (예: 알고리즘 문제 풀기)
3. `/export conversation.md` 로 대화 내용 파일로 저장
4. 저장된 파일 확인: `cat conversation.md`
5. `/copy` 로 마지막 응답 클립보드 복사 후 에디터에 붙여넣기 확인

---

## 완료 체크

모두 완료했으면 PRACTICE.md에 기록하고 `03-config/`로 이동!
