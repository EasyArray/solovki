var parentDragged = null;
var parentParent = null;
var n = null; // Selected node
var tn = null; // Selected tree
var traceCount = 0;
var preventRename = false;

function highlightTree(list, val)
{
	if (val)
	{
		list.setStyle('cursor', 'crosshair');
		list.setStyle('color', 'red');
	}
	else
	{
		list.setStyle('cursor', '');
		list.setStyle('color', '');
	}
}

function renameNode(event)
{
	if (preventRename)
	{
		//alert("Preventing rename.");
		preventRename = false;
		return true;
	}
	
	el = $(event.target);
	if (el != $$('.selectedNode')[0]) return;
	
	var name = prompt("Enter a new name for the node.");
	if (name == null || name == "") return;
	
	el.id = name;
	//el.innerText = el.innerText.replace(/^.*$/, name);
	el.firstChild.textContent = name;
}

function addDaughter(event)
{
	el = $(event.target.parentNode);
	var name = prompt("Enter a name for the new node.");
	if (name == null || name == "") return;
	
	var n = new Element('li');
	n.innerHTML = name;
	n.id = name;
	var ul = $$('#' + el.id + ' > ul')[0];
	if (ul != undefined)
	{
		ul.appendChild(n);
	}
	else
	{
		ul = new Element('ul');
		el.appendChild(ul);
		ul.appendChild(n);
	}
	event.stop();
	return false;
}

function deselectNode(el)
{
	el = $(el);
	el.removeClass('selectedNode');
	el.removeEvent('click', renameNode);
	$('tree_addLink').destroy();
	n.detach();
	n = null;
}

function selectNode(event)
{
	el = $(event.target);
	var a = $$('.selectedNode');
	if (a.length > 0)
		deselectNode(a[0]);
	
	//el = $(el);
	if (el.get('tag') != 'li')
		el = $(el.firstChild);
	el.addClass('selectedNode');
	el.addEvent('click', renameNode);
	
	var href = new Element('a');
	href.innerHTML = "[+]";
	href.href = '#';
	href.addEvent('click', addDaughter);
	href.id = "tree_addLink";
	
	el.appendChild(href);
	
	n = new Nested($('mainlist'), {'lock':'class', 'lockClass':'selectedNode'});
	preventRename = false;
}

window.addEvent('domready', function() 
{
	$('mainlist').addEvent('click', selectNode);
});

function makeTreeMove(t)
{
	if (n != null)
	{
		deselectNode(n.list);
	}
	
	if (tn != null)
	{
		tn.detach();
		tn = null;
		highlightTree($('mainlist'), false);
	}
	else
	{
		highlightTree($('mainlist'), true);
	tn = new Nested('mainlist', {
		onStart:function(el)
		{
			//Store where the thing that's being dragged was so we can drop a trace later.
			parentDragged = el.parentNode;
			parentParent = el.parentNode.parentNode;
		},

		onComplete:function(el)
		{
			//Stick a tracer where it was and label it as such IF this thing was dragged to the same level as 'S'.
			//Make the trace element.
			el2 = new Element('li');
			el2.innerHTML = "t_" + traceCount;
			el2.id = el2.innerHTML;
			//If the nested thingy removed a level of nesting, re-add it.
			if (parentDragged.parentNode != parentParent)
			{
				parentDragged.injectInside(parentParent);
			}
			//Put the trace element where it belongs.
			el2.injectInside(parentDragged);
		
			//Make the new S element
			oldS = $('S');
			oldS.id = "S_" + traceCount;
		
			//Make the new list hierarchy--there needs to be two new outer S <li><ul> things.
			newSul1 = new Element('ul');
			newSli1 = new Element('li', {'id':'S'});
			newSli1.innerHTML = 'S';
			el.innerHTML = el.innerHTML.replace(/^(\w+)/, function($0, $1) {return $1 + '_' + traceCount;});
			el.id = el.id + '_' + traceCount;
		
			$('mainlist').appendChild(newSli1);
			newSli1.appendChild(newSul1); //By the end: <ul><li id='S'>S</li><ul>...TREE...</ul></ul>
			newSul1.appendChild(el);
		
			newSul2 = new Element('ul');
			newSli2 = new Element('li', {'id':'S' + traceCount});
			newSli2.innerHTML = "S";
			newSliT = new Element('li', {'id':traceCount});
			newSliT.innerHTML = traceCount;
		
			newSul1.appendChild(newSli2);
			newSli2.appendChild(newSul2);
		
			newSul2.appendChild(newSliT);
			newSul2.appendChild(oldS);
		
			//newSul2.appendChild(newSliT);
			//newSli2.appendChild(newSul2);
		
			//newSul2.appendChild(oldS);
			//newSul1.appendChild(newSli2);
		
			traceCount++;
			makeTreeMove(null);
		}});
	}
}

function makeReorder()
{
	if (n != null)
	{
		n.detach();
		n = null;
		highlightTree($('mainlist'), false);
	}
	else
	{
		highlightTree($('mainlist'), true);
		n = new Nested('mainlist');
	}
}

function loading()
{
	str = $('bracket').value;
	str = str.replace(/\[\.(\w+) /g, function($0, $1) { return "<node t='" + $1 + "'>"; } );
	str = "<tree>" + str.replace(/ \]/g, "</node>") + "</tree>";
	new Transformation()
	    .setXml(str)
	    .setXslt('listTransform.xsl')
		.setCallback(function(t)
		{
			//makeNested(t);
			$('mainlist').addEvent('click', selectNode);
		})
	    .transform('treeAnchor');
}

function saving()
{
	//Serialize the result.
	new Transformation()
		.setXml($('treeAnchor').innerHTML.replace(/xmlns=".*?"/, ''))
	    .setXslt('listTransformBack.xsl')
		.setCallback(function(t)
		{
			//var bracket = $('placeholder').innerHTML.replace(/<\/?tree.*?>/g, '').replace(/<node t="(\w+)">/g, function($0, $1) { return " [." + $1 + ' '; }).replace(/<\/node>/g, ' ]');
			//var bracket = $('placeholder').innerHTML.replace(/<node.*?>/g, '[').replace(/<\/node>/g, ']').replace(/\]\s+\[/g, ',').replace(/<\/?tree.*?>\s+[\]\[]/g, ', ');
			var bracket = $('placeholder').innerHTML.replace(/<node.*?>/g, '[').replace(/<\/node>/g, ']').replace(/\]\s*\[/g, ',').replace(/<tree.*?>\s*[\]\[]/g, ', ').replace(/(\]\s*)<\/tree>/g,'').replace(/^\s+,\s*/g,'');
			//alert(bracket);
			$('treeOutput').value = $('placeholder').innerHTML + "\n" + bracket;
			/*var req = new Request.HTML({
				method: 'get',
				url: "test.php",
				data: { 'input' :  bracket },
				//onRequest: function() { alert('Request made. Please wait...'); },
				//update: $('dispBackend'),
				onSuccess: function(responseText, responseXML)
				{ alert('Request completed successfully: ' + responseText);
					$('treeOutput').value = responseText[0].data; //setStyle('background','#fffea1');
				}
			}).send();*/
		})
		.transform('placeholder');
}

var bound = null;

function treeCatchClick(treeFunc)
{
	if (!$('mainlist')) return;
	if (bound != null) return;
	highlightTree($('mainlist'), true);
	
	function catchClick(event, list)
	{
		var el = $(event.target);
		//alert(el.id);
		if (el.id == 'mainlist') el = $$('#mainlist > li')[0];
		
		highlightTree($('mainlist'), false);
		event.stop();
		list.removeEvent('click', bound);
		bound = null;
		treeFunc(el);
	}
	
	l = $('mainlist');
	bound = catchClick.bindWithEvent(this, l);
	l.addEvent('click', bound);
}

function treeAddDaughter()
{
	function treeClick(el)
	{				
		var name = prompt("Enter a name for the new node.");
		if (name == null || name == "") return;
		
		var n = new Element('li');
		n.innerHTML = name;
		n.id = name;
		var ul = $$('#' + el.id + ' > ul')[0];
		if (ul != undefined)
		{
			ul.appendChild(n);
		}
		else
		{
			ul = new Element('ul');
			el.appendChild(ul);
			ul.appendChild(n);
		}
	}
	
	treeCatchClick(treeClick);
}

function treeRename()
{
	function treeClick(el)
	{				
		var name = prompt("Enter a new name for the new node.");
		if (name == null || name == "") return;
		
		el.id = name;
		//el.innerText = el.innerText.replace(/^.*$/, name);
		el.firstChild.textContent = name;
	}
	
	treeCatchClick(treeClick);
}

function treeDelete()
{
	function treeClick(el)
	{
		el.destroy();
	}
	
	treeCatchClick(treeClick);
}
