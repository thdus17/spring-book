#!/usr/bin/env bash
# bash는 return value가 안 되니 *제일 마지막줄에 echo로 결과 출력*후, 클라이언트에서 값 사용
# 쉬고 있는 profile 찾기 ex: real1이 사용 중이면 real2가 쉼
function find_idle_profile() {
  RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/profile)

  if [ ${RESPONSE_CODE} -ge 400 ] # 400보다 크면 (40x/50x 에러 포함)
  then
    CURRENT_PROFILE=real2
  else
    CURRENT_PROFILE=$(curl -s http://localhost/profile)
  fi

  if [ ${CURRENT_PROFILE} == real1 ]
  then
    IDLE_PROFILE=real2
  else
    IDLE_PROFILE=real1
  fi

  echo "${IDLE_PROFILE}"
}

# 쉬고 있는 profile의 port 찾기
function find_idle_port() {
    IDLE_PROFILE=$(find_idle_profile)

    if [ ${IDLE_PROFILE} == real1 ]
    then
      echo "8083"
    else
      echo "8082"
    fi
}