(function(window) {
    var urlParams = new URLSearchParams(window.location.search);
    var publicationId = urlParams.get('adways_id');
  
    if (publicationId) {
      var adways_script = document.createElement('script');
      adways_script.setAttribute('src', 'https://dj5ag5n6bpdxo.cloudfront.net/libs/interactive/loader.js');
      adways_script.setAttribute('type', 'text/javascript');
      document.getElementsByTagName('head')[0].appendChild(adways_script);
  
      adways_script.onload = function () {
        document.addEventListener('marsha_player_created', function(event) {
          var adways = window.adways;
  
          var experience = new adways.interactive.Experience();
          experience.setPublicationID(publicationId);
          experience.setPlayerAPI(event.detail.videoNode);
          experience.setPlayerClass("HTML5");
          experience.setSceneTimeReference(false); //true for live interactivity (i.e. based on user time instead of video time).
          experience.load();
        });
      }
    }
  })(window);
