Ideal Select
==================

Small select dropdown replacement.

**Support:** IE9+ and modern browsers  
**Demo:** http://jsbin.com/uMahupU/3

### How To

Load:

```html
<script src="js/jquery.idealselect.min.js"></script>
<link rel="stylesheet" href="css/jquery.idealselect.css">
```

Create `select`:

```html
<select id="states" name="states">
  <option value="AL">Alabama</option>
  ...
</select>
```

Initialize:
```javascript
// Only single select supported
$('select:not([multiple])').idealselect();
```

### Events

Just trigger events on the original select element:

```javascript
$('#states').change(function() {
  console.log('triggered!');  
});
```

### Dynamic

If you add more elements to your select make sure to build the markup again:

```javascript
var options = [
  '<option value="one">One</option>',
  '<option value="two">Two</option>',
  '<option value="three">Three</option>'
];
$('#states').append(options.join('')).idealselect('_build');
```
