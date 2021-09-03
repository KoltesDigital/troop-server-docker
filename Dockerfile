# syntax=docker/dockerfile:1.3

FROM alpine/git AS builder
ARG COMMIT=OT
ARG REPOSITORY=https://github.com/Qirky/Troop
RUN git clone $REPOSITORY . && \
	git -c advice.detachedHead=false checkout $COMMIT && \
	( \
	COMMIT=$(git rev-parse --verify HEAD); \
	echo && \
	echo -e "To prevent protocol errors, \e[4mensure all participants\e[0m use the client from this commit:" && \
	echo -e "\e[1m\e[92m"$COMMIT"\e[0m" && \
	echo "Download sources:" && \
	echo -e "\e[4m"$REPOSITORY"/archive/"$COMMIT".zip\e[0m" && \
	echo \
	)

FROM python:3-alpine
WORKDIR /app
COPY ./run.py ./
COPY --from=builder /git/src ./src/
RUN addgroup -S app && adduser -S app -G app
USER app
EXPOSE 57890
ENTRYPOINT ["python", "run.py"]
