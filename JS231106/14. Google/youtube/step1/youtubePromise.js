const mostVideo = () => {
  return new Promise((resolve, reject) => {
    fetch("https://www.googleapis.com/youtube/v3/videos?part=snippet&key=AIzaSyCcvgxRhPCt-yVa-BcpGUi1dmM4hKYiEi4&maxResults=3&chart=mostPopular")
      .then(res => {
        const data = res.json();
        console.log(data);
        console.log(data.items);
        //location.href='./index.html'
      })
      .catch(error => console.log('error', error));
  })
}

const wrapping = async () => {
  await mostVideo();
}
