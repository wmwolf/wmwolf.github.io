function fixDims(oldTag, newWidth = 896, newHeight = 504) {
    return oldTag
      .replace(/width="(\d+)"/, `width="${newWidth}"`)
      .replace(/height="(\d+)"/, `height="${newHeight}"`)
      .replace(/playerSize%2F(\d+)x(\d+)%2F/, `playerSize%2F${newWidth}x${newHeight}%2F`)
      .replace(/style="width: (\d+)px; height: (\d+)px;"/, `style="width: ${newWidth}px; height: ${newHeight}px;"`);
  }
  
  function fixSkin(oldTag, newSkin = 54949472) {
    return oldTag.replace(/playerSkin%2F(\d+)%2F/, `playerSkin%2F${newSkin}%2F`);
  }
  
  function trimSrc(oldTag) {
    return oldTag.replace(/src="https:\/\/uweau.instructure.com/, 'src="');
  }
  
  function addAttributes(oldTag) {
    let result = oldTag.replace(/allow="geolocation \*; microphone \*; camera \*; midi \*; encrypted-media \*; autoplay \*"/, 
      'allow="geolocation *; microphone *; camera *; midi *; encrypted-media *; autoplay *; clipboard-write *; display-capture *"');
  
    if (!result.includes('lti-embed')) {
      result = result.replace(/<iframe /, '<iframe class="lti-embed" ');
    }
  
    return result;
  }
  
  function updateTag(oldTag, newWidth = 896, newHeight = 504, newSkin = 54949472) {
    return addAttributes(fixSkin(fixDims(trimSrc(oldTag), newWidth, newHeight), newSkin));
  }

  function get_new_dims() {
    const selectVal = document.getElementById('new-dimensions').value;
    // split the value into an array using "x" as the delimiter
    const dims = selectVal.split('x');
    // return the array
    return dims;
  }

  function update_output() {
    const oldTag = document.getElementById('old-kaltura').value;
    const newDims = get_new_dims();
    const newWidth = newDims[0];
    const newHeight = newDims[1];
    const newTag = updateTag(oldTag, newWidth, newHeight);
    document.getElementById('new-kaltura').innerText = newTag;

    // Update the copy button
    const copyBtn = document.querySelector('.copy-btn');
    copyBtn.classList.remove('btn-secondary');
    copyBtn.classList.add('btn-primary');
    copyBtn.innerHTML = 'Copy';
  }

// document ready
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.copy-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            // Select the text from the <code> block
            const codeElement = document.getElementById('new-kaltura');
            const range = document.createRange();
            range.selectNodeContents(codeElement);
            
            const selection = window.getSelection();
            selection.removeAllRanges();
            selection.addRange(range);
            
            // Copy the selected text to the clipboard
            try {
                document.execCommand('copy');
                btn.classList.add('btn-secondary');
                btn.classList.remove('btn-primary');
                btn.innerHTML = 'Copied!';
                // alert('Code copied to clipboard!');
            } catch (err) {
                console.log('Failed to copy code.');
            }
            
            // Deselect the text
            selection.removeAllRanges();
        });
    });
    document.getElementById('old-kaltura').addEventListener('input', function() {
        update_output();
    });
    document.getElementById('new-dimensions').addEventListener('change', function() {
        update_output();
    });
});
