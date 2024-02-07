import { LightningElement, track } from 'lwc';

export default class ParentSlider extends LightningElement {
    @track slides = [
        {
            "image": "https://upload.wikimedia.org/wikipedia/commons/f/f9/Phoenicopterus_ruber_in_S%C3%A3o_Paulo_Zoo.jpg",
            "heading": "High School Education System",
            "description": "It's new for me also"
        }, {
            "image": "https://upload.wikimedia.org/wikipedia/commons/f/f9/Phoenicopterus_ruber_in_S%C3%A3o_Paulo_Zoo.jpg",
            "heading": "Middle School Education System",
            "description": "so what are you thinking"
        }, {
            "image": "https://upload.wikimedia.org/wikipedia/commons/f/f9/Phoenicopterus_ruber_in_S%C3%A3o_Paulo_Zoo.jpg",
            "heading": "Next school",
            "description": "It's ok for 1-10"
        
        }
      ];
}