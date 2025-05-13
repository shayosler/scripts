#!/bin/bash -x

# Close streams at the end
cleanup()
{
  for (( s=0; s<${#stream_pids[@]}; s++ ))
  do
    kill ${stream_pids[$s]} || echo "Stream $s already stopped"
  done
  
  if [[ ! -z "$container_name" ]]
  then
    docker container kill "$container_name" || echo "Could not kill rtsp server container"
  fi
}
trap cleanup EXIT

# Args passed as --arg [val]
# Default values
src="$1"
n_streams=1
while test $# -gt 0
do
  case "$1" in
    --src)
      src="$2"
      shift
      ;;
    --streams)
      n_streams="$2"
      shift
      ;;    
    
    #Catch all other arguments passed as --<arg> here
    --*)
      echo "Unknown option $1"
      exit 1
      ;;
    #Catch all other args here
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
  shift
done

# Launch RTSP server: https://github.com/bluenviron/mediamtx
prefix="$(date '+%Y%m%d%H%M%S')"
container_name="${prefix}_rtsp_server"
docker run --rm \
       -e MTX_PROTOCOLS=tcp \
       -e MTX_WEBRTCADDITIONALHOSTS=192.168.1.137 \
       -p 8554:8554 \
       -p 1935:1935 \
       -p 8888:8888 \
       -p 8889:8889 \
       -p 8890:8890/udp \
       -p 8189:8189/udp \
       --name "$container_name" \
       bluenviron/mediamtx &> /dev/null &

# Launch streams
rtsp_url="rtsp://localhost:8554"
stream_pids=()
for (( s=0; s<"$n_streams"; s++ ))
do
  stream="${rtsp_url}/stream${s}"
  echo "Launching stream at rtsp://localhost:8554/${stream}"
  ffmpeg_stream.sh --loop --src "$src" --fmt rtsp --dest "$stream" &> /dev/null &
  stream_pids+=($!)
  sleep 1
done
echo "${stream_pids[@]}"

# Wait
while :; do sleep 1000; done
