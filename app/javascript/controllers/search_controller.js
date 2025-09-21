import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        console.log("SearchController connected")
        this.timeout = null
    }

    submit(event) {
        clearTimeout(this.timeout)
        this.timeout = setTimeout(() => {
            console.log("Submitting search form")
            this.element.requestSubmit()
        }, 300)
    }
}