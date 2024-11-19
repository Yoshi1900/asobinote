import { Controller } from "@hotwired/stimulus"
import { Loader } from "@googlemaps/js-api-loader"

export default class extends Controller {
  // 地図の設定。APIキーはHTML上で見えるので、Google側で要制限
  setLoader() {
    return new Loader({
      apiKey: ENV['GOOGLE_API_KEY'],
      version: "weekly",
    });
  }
}