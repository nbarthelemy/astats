import React from 'react'

const feather = require('feather-icons');

class Report extends React.Component {

  constructor(props) {
    super(props);

    this.title = props.title;
    this.description = props.description;
    this.headers = props.headers;
    this.dataurl = props.dataurl;
    this.rowRenderer = props.rowRenderer;

    this.renderTable = this.renderTable.bind(this);

    this.state = { data: { } };
  }

  componentWillMount(props){
    let init = {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' },
      cache: 'default'
    };

    let request = new Request(this.dataurl, init);

    fetch(request, init).then((response) => {
      if( response.ok ){
        response.json().then((json) => {
          this.setState({ data: json });
        });
      } else {
        console.log(response.statusText);
      }
    })
    .catch((error) => {
      console.log("Error: " + error.message);
    })
  }

  renderHeaders() {
    let ths = new Array;
    ths.push(this.headers.map((header, i) => {
      return(<th key={`header-${i}`}>{header}</th>);
    }));

    return(
      <tr>{ths}</tr>
    );
  }

  renderTable(){
    return (
      <div className="table-responsive">
        <table className="table table-sm">
          <thead>
            {this.renderHeaders()}
          </thead>
          <tbody>
            {this.rowRenderer(this.state.data)}
          </tbody>
        </table>
      </div>
    );
  }

  render(){
    return (
      <div>
        <div className="pt-3 mb-3" >
          <h2>{this.title}</h2>
          <p>{this.description}</p>
        </div>
        {this.renderTable()}
      </div>
    );
  }
}

export default Report