Ideal Select
==================

Small select dropdown replacement.

**Support:** IE9+ and modern browsers
**Demo:** http://jsbin.com/uMahupU/1

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
