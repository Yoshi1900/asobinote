
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
});



// ライブラリの読み込み
let map;

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker")
  // 地図の中心と倍率は公式から変更しています。
  map = new Map(document.getElementById("map"), {
    center: { lat: 	36.7017294, lng: 137.2132271 }, 
    zoom: 15,
    mapId: "DEMO_MAP_ID",
    mapTypeControl: false
  });
  try {
    const response = await fetch("/playgrounds.json");
    if (!response.ok) throw new Error('Network response was not ok');

    const { data: { playground } } = await response.json();
    if (!Array.isArray(playground)) throw new Error("playgrounds is not an array");

    playgrounds.forEach( playground => {
      const latitude = playground.latitude;
      const longitude = playground.longitude;
      const shopName = playground.name;
      const userImage = playground.user.avatar_image;
      const userName = playground.user.nickname;
      const postImage = playground.playground_images;
      const address = playground.address;
      const caption = playground.description;

      const marker = new google.maps.marker.AdvancedMarkerElement ({
        position: { lat: latitude, lng: longitude },
        map,
        title: Name,
        // 他の任意のオプションもここに追加可能
      });
    });

  // 追記
  const contentString = `
  <div class="information container p-0">
    <div class="mb-3 d-flex align-items-center">
      <img class="rounded-circle mr-2" src="${userAvatarImage}" width="40" height="40">
      <p class="lead m-0 font-weight-bold">${userNIckname}</p>
    </div>
    <div class="mb-3">
      <img class="thumbnail" src="${PlaygroundImage}" loading="lazy">
    </div>
    <div>
      <h1 class="h4 font-weight-bold">${Name}</h1>
      <p class="text-muted">${address}</p>
      <p class="lead">${description}</p>
    </div>
  </div>
  `;

  const infowindow = new google.maps.InfoWindow({
  content: contentString,
  ariaLabel: Name,
  });

  marker.addListener("click", () => {
    infowindow.open({
    anchor: marker,
    map,
  })
  });

  } catch (error) {
    console.error('Error fetching or processing post images:', error);
  }

}

initMap()