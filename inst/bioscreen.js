function addBioscreenPlate(d,i) {

  const plateParams = ({width: 85.48,
                        height: 127.76,
                        hWellPadding: 10.9,
                        vWellPadding: 7.76,
                        iWellPadding: 0.227,
                        wellShape: 'circle'});

 const data = [{"well":1,"row":1,"col":1},{"well":2,"row":3,"col":1},{"well":3,"row":5,"col":1},{"well":4,"row":7,"col":1},{"well":5,"row":9,"col":1},{"well":6,"row":11,"col":1},{"well":7,"row":13,"col":1},{"well":8,"row":15,"col":1},{"well":9,"row":17,"col":1},{"well":10,"row":19,"col":1},{"well":11,"row":2,"col":2},{"well":12,"row":4,"col":2},{"well":13,"row":6,"col":2},{"well":14,"row":8,"col":2},{"well":15,"row":10,"col":2},{"well":16,"row":12,"col":2},{"well":17,"row":14,"col":2},{"well":18,"row":16,"col":2},{"well":19,"row":18,"col":2},{"well":20,"row":20,"col":2},{"well":21,"row":1,"col":3},{"well":22,"row":3,"col":3},{"well":23,"row":5,"col":3},{"well":24,"row":7,"col":3},{"well":25,"row":9,"col":3},{"well":26,"row":11,"col":3},{"well":27,"row":13,"col":3},{"well":28,"row":15,"col":3},{"well":29,"row":17,"col":3},{"well":30,"row":19,"col":3},{"well":31,"row":2,"col":4},{"well":32,"row":4,"col":4},{"well":33,"row":6,"col":4},{"well":34,"row":8,"col":4},{"well":35,"row":10,"col":4},{"well":36,"row":12,"col":4},{"well":37,"row":14,"col":4},{"well":38,"row":16,"col":4},{"well":39,"row":18,"col":4},{"well":40,"row":20,"col":4},{"well":41,"row":1,"col":5},{"well":42,"row":3,"col":5},{"well":43,"row":5,"col":5},{"well":44,"row":7,"col":5},{"well":45,"row":9,"col":5},{"well":46,"row":11,"col":5},{"well":47,"row":13,"col":5},{"well":48,"row":15,"col":5},{"well":49,"row":17,"col":5},{"well":50,"row":19,"col":5},{"well":51,"row":2,"col":6},{"well":52,"row":4,"col":6},{"well":53,"row":6,"col":6},{"well":54,"row":8,"col":6},{"well":55,"row":10,"col":6},{"well":56,"row":12,"col":6},{"well":57,"row":14,"col":6},{"well":58,"row":16,"col":6},{"well":59,"row":18,"col":6},{"well":60,"row":20,"col":6},{"well":61,"row":1,"col":7},{"well":62,"row":3,"col":7},{"well":63,"row":5,"col":7},{"well":64,"row":7,"col":7},{"well":65,"row":9,"col":7},{"well":66,"row":11,"col":7},{"well":67,"row":13,"col":7},{"well":68,"row":15,"col":7},{"well":69,"row":17,"col":7},{"well":70,"row":19,"col":7},{"well":71,"row":2,"col":8},{"well":72,"row":4,"col":8},{"well":73,"row":6,"col":8},{"well":74,"row":8,"col":8},{"well":75,"row":10,"col":8},{"well":76,"row":12,"col":8},{"well":77,"row":14,"col":8},{"well":78,"row":16,"col":8},{"well":79,"row":18,"col":8},{"well":80,"row":20,"col":8},{"well":81,"row":1,"col":9},{"well":82,"row":3,"col":9},{"well":83,"row":5,"col":9},{"well":84,"row":7,"col":9},{"well":85,"row":9,"col":9},{"well":86,"row":11,"col":9},{"well":87,"row":13,"col":9},{"well":88,"row":15,"col":9},{"well":89,"row":17,"col":9},{"well":90,"row":19,"col":9},{"well":91,"row":2,"col":10},{"well":92,"row":4,"col":10},{"well":93,"row":6,"col":10},{"well":94,"row":8,"col":10},{"well":95,"row":10,"col":10},{"well":96,"row":12,"col":10},{"well":97,"row":14,"col":10},{"well":98,"row":16,"col":10},{"well":99,"row":18,"col":10},{"well":100,"row":20,"col":10}];

  const sel = d3.select(this);

  const x = d3.scaleBand()
                .domain([1,2,3,4,5,6,7,8,9,10])
                .range([0, plateParams.width])
                .paddingInner(0)
                .paddingOuter(0.5);

  const y = d3.scaleBand()
                .domain([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20])
                .range([0, plateParams.height])
                .paddingInner(0)
                .paddingOuter(1);

  const plateSVG = sel.append('svg')
    .attr('class', 'plate')
    .attr('viewBox', [0, 0, plateParams.width, plateParams.height].join(' '))
    .attr('preserveAspectRatio', 'xMidYMid meet')
    .attr('width', sel.attr('width'))
    .attr('height', sel.attr('height'));

  plateSVG.append('polyline')
    .attr('class', 'outer-border')
    .attr('stroke', '#bbb')
    .attr('fill', 'none')
    .attr('stroke-width', 0.25)
    .attr('points', `0,0 ${plateParams.width},0 ${plateParams.width},${plateParams.height} 7,${plateParams.height} 0,${plateParams.height - 7} 0,0`);

  const wells = plateSVG.selectAll('g.well')
    .data(data)
    .enter().append('g')
    .attr('class', 'well')
    .attr('data-well', d => d.well)
    .attr('transform', d => `translate(${x(d.col)},${y(d.row)})`);

  wells.each(function(d) {
    if (plateParams.wellShape === 'rect') {
      d3.select(this).append('rect')
       .attr('class', 'well-border')
       .attr('stroke-width', 0.25)
       .attr('stroke','#bbb')
       .attr('fill', 'none')
       .attr('width', x.bandwidth())
       .attr('height', x.bandwidth())
       .attr('rx', 0)
       .attr('ry', 0);
    }
    if (plateParams.wellShape === 'circle') {
      d3.select(this).append('circle')
       .attr('class', 'well-border')
       .attr('pointer-events', "all") // FIXME
       .attr('stroke-width', 0.25)
       .attr('stroke','#bbb')
       .attr('fill', 'none')
       .attr('r', x.bandwidth() * 1.1 / 2)
       .attr('cx', x.bandwidth() / 2)
       .attr('cy', y.bandwidth() / 2);
    }
    d3.select(this).append('text')
       .text(d => d.well)
       .attr('font-size', x.bandwidth() / 2)
       .attr('class', 'well-label')
       .attr('x', x.bandwidth() / 2)
       .attr('y', y.bandwidth() / 2)
       .attr("text-anchor", "middle")
       .attr("alignment-baseline", "middle")
       .attr("opacity",0);
  });

}

svg.append('rect')
    .attr('class', 'carousel')
    .attr('width', width)
    .attr('height', height)
    .attr('fill','none')
    .attr('stroke-width', 0.25)
    .attr('stroke','#bbb')
    .attr('rx', 4)
    .attr('ry', 4);

  const trays = svg.selectAll('.trays')
    .data(data)
    .enter().append('g')
    .attr('class', 'tray')
    .attr('width', width * 0.9 / 2)
    .attr('height', height * 0.9)
    .attr('transform', (d,i) => `translate(${(width * 0.9 / data.length) * i + (width * 0.1 * i)},${height * 0.05})`);

  trays.each(addBioscreenPlate);

var groupData = [];


  svg.selectAll('.well').on("click", function(d,i){
    const plate = d3.select(this.parentNode);
    var refWells = (plate.attr('data-reference-wells') || '').split(',');
    const well = d3.select(this);

    var current = well.attr('data-well');
    console.log('clicked on well: ' + current);

    // if already a reference well, click to remove
    if(refWells.indexOf(current) !== -1) {
      well.select('.well-border').attr('fill', 'none');
      well.select('text').attr('opacity', '0');
      refWells.splice(refWells.indexOf(current), 1);
    } else {
      // style as selected
      well.select('.well-border').attr('fill', 'red').attr('fill-opacity', 0.5);
      well.select('text').attr('opacity', '0.5');
      refWells.push(current);
    }


    d3.select(this.parentNode).attr('data-reference-wells', refWells.join(','));

    console.log('updated refs: ' + d3.select(this.parentNode).attr('data-reference-wells'));
  });

  svg.selectAll('.well').on("dblclick", function(d,i){
    const plate = d3.select(this.parentNode);
    const well = d3.select(this);

    var current = well.attr('data-well');
    console.log('DOUBLE clicked on well: ' + current);

      well.select('.well-border').attr('fill', 'red').attr('fill-opacity', 1);
      well.select('text').attr('opacity', '1');



    d3.select(this.parentNode).attr('data-reference-wells', refWells.join(','));

    console.log('updated refs: ' + d3.select(this.parentNode).attr('data-reference-wells'));
  });
