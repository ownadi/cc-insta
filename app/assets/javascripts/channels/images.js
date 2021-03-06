$(document).on('ready', function() {
  App.images = App.cable.subscriptions.create({ channel: 'ImagesChannel' }, {
    connected: function() {
      $('.loader-upload').hide();
      $('.btn-upload').show();
      window.cableConnected = true
    },
    disconnected: function(){
      $('.btn-upload').hide();
      $('.loader-upload').show();
      window.cableConnected = false
    },
    received: function(data) {
      switch(data.event) {
        case 'new_image':
          $('.img-grid').prepend(data.contents);
          break;
        case 'update_image':
          var oldImage = $('.img-entry[data-id=' + data.id + ']').closest('.image-entry');
          oldImage.hide();
          oldImage.after(data.contents);
          oldImage.remove();
          break;
        case 'delete_image':
          var image = $('.img-entry[data-id=' + data.id + ']').closest('.image-entry');
          image.remove();
        default:
          return;
      }
    }
  });
});
