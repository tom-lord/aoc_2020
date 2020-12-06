mkdir -p $1

curl "https://adventofcode.com/2020/day/$1/input" \
  -H 'authority: adventofcode.com' \
  -H 'cache-control: max-age=0' \
  -H 'cookie: _ga=GA1.2.1457494086.1606834991; _gid=GA1.2.443515268.1606834991; session=53616c7465645f5fc83b1b59107bf7b4a8bc3899d106379e9c9966f83d8c123d9e091e82920ef7f7aa2e0ab8c9a562b4; _gat=1' \
  --compressed > "./$1/input"
