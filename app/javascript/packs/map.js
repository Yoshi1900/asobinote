
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

    const { data: { playgrounds } } = await response.json();
    if (!Array.isArray(playgrounds)) throw new Error("playgrounds is not an array");
  
    console.log(playgrounds);

    playgrounds.forEach( playground => {
      const latitude = playground.latitude;
      const longitude = playground.longitude;
      const playground_name = playground.playground_name;
      const playground_images = playground.playground_images;
      const address = playground.address;
      const description = playground.description;

      const marker = new google.maps.marker.AdvancedMarkerElement ({
        position: { lat: latitude, lng: longitude },
        map: map,
        title: playground_name,
        // 他の任意のオプションもここに追加可能
      });

  // 最初の画像または「画像がありません」を判定
       const imageElement = playground_images && playground_images.length > 0
    ? `<img src="${playground_images[0]}" alt="${playground_name}" class="img-fluid mb-3">`
    : `<p class="text-muted mb-3">画像がありません</p>`;


       // 追記
      const contentString = `
  <div class="information container p-0">
    <div class="information container p-0">
    ${imageElement}
    <div>
    <div>
      <h1 class="h4 font-weight-bold">${playground_name}</h1>
      <p class="text-muted">${address}</p>
      <p class="lead">${description}</p>
    </div>
  </div>
  `;

      const infowindow = new google.maps.InfoWindow({
        content: contentString,
        ariaLabel: name,
      });

      marker.addListener("click", () => {
        infowindow.open({
        anchor: marker,
        map: map,
        })
 
      });

    });

  } catch (error) {
    console.error('Error fetching or processing post images:', error);
  }

}

initMap()