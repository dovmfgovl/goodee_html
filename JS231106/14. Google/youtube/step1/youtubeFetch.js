const requestOptions = {
  method: 'GET',
  redirect: 'follow'
};

fetch("https://www.googleapis.com/youtube/v3/videos?part=snippet&key=AIzaSyCcvgxRhPCt-yVa-BcpGUi1dmM4hKYiEi4&maxResults=3&chart=mostPopular", requestOptions)
  .then(async response => {
    const data = await response.json();
    console.log(data);
    console.log(data.items);
    console.log(JSON.stringify(data));
  })
  .catch(error => console.log('error', error));

