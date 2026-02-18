# 05단계 미션

---

## 미션 1: 현재 MCP 서버 확인 ⭐

```bash
# 등록된 MCP 서버 목록
claude mcp list

# 설정 파일 직접 확인
cat ~/.claude.json 2>/dev/null | python3 -m json.tool | grep -A 30 '"mcpServers"' || echo "없음"
```

**기록**: 현재 등록된 서버들과 상태

---

## 미션 2: fetch 서버 추가 & 테스트 ⭐⭐

웹 페이지를 가져올 수 있는 MCP 서버를 추가하세요.

```bash
# fetch 서버 추가
claude mcp add --transport stdio fetch \
  -- npx -y @modelcontextprotocol/server-fetch

# 추가 확인
claude mcp list
```

테스트:
```bash
claude -p "https://example.com 의 내용을 fetch 도구로 가져와서 요약해줘"
```

**성공 기준**: Claude가 실제로 웹 페이지 내용을 가져와서 요약

---

## 미션 3: filesystem 서버 추가 ⭐⭐

```bash
# 현재 폴더에 대한 filesystem 접근 허용
claude mcp add --transport stdio filesystem-tutorial \
  -- npx -y @modelcontextprotocol/server-filesystem \
  /Users/donghun2/workspace/awesome-claude-code/claude-tutorial
```

테스트:
```bash
claude -p "filesystem 도구를 사용해서 claude-tutorial 폴더의 모든 파일을 나열하고 총 파일 수를 알려줘"
```

---

## 미션 4: .mcp.json 팀 공유 설정 ⭐⭐⭐

이 프로젝트에 .mcp.json을 만들어서 팀원들도 같은 MCP 서버를 쓸 수 있게 하세요.

```bash
cat > /Users/donghun2/workspace/awesome-claude-code/.mcp.json << 'EOF'
{
  "mcpServers": {
    "fetch": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"]
    }
  }
}
EOF
```

**확인**: 새 터미널에서 claude 실행 후 fetch 서버가 자동으로 로드되는지 확인

---

## 미션 5: /mcp 명령어 탐색 ⭐⭐

```bash
claude  # 인터랙티브 모드 시작
```

인터랙티브 모드에서:
```
/mcp
```

UI에서 탐색:
- 서버 목록 확인
- 각 서버의 도구 목록
- 서버 활성화/비활성화
- OAuth 인증 (있는 경우)

---

## 미션 6: MCP 서버 제거 & 관리 ⭐⭐

```bash
# 특정 서버 상세 정보
claude mcp get filesystem-tutorial

# 서버 제거
claude mcp remove filesystem-tutorial

# 다시 확인
claude mcp list
```

---

## 도전 미션: memory 서버로 영구 메모리 ⭐⭐⭐⭐

```bash
# memory MCP 서버 추가
claude mcp add --transport stdio persistent-memory \
  -- npx -y @modelcontextprotocol/server-memory
```

테스트:
1. `claude` 실행
2. "내 이름은 [당신이름]이고 Python 개발자야. 이걸 기억해줘"
3. `/clear` 로 컨텍스트 초기화
4. "내 이름이 뭐야?" 질문
5. 영구 메모리에서 기억하는지 확인

**이것이 CLAUDE.md와 다른 점**: MCP memory는 세션간 구조화된 데이터 저장

---

## 완료 체크

PRACTICE.md에 기록하고 `06-agents/`로!
