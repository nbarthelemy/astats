import React from 'react'
import Report from '../report'

const feather = require('feather-icons');

class TopReferrersReport extends React.Component {

  render() {
    return(
      <Report title="Top Referrers"
        description="Top 5 referrers for the top 10 URLs grouped by day, for the past 5 days."
        dataurl="/api/v1/top_referrers"
        headers={["Url", "Number of Visits"]}
        rowRenderer={this.renderRows} />
    )
  }

  componentDidMount(){
    feather.replace();
  }

  renderRows(data){
    let rows = new Array

    for (let date in data){
      let section = new Array
      let totalVisits = 0

      for (let url in data[date]){
        let resource = data[date][url];

        section.push(
          <tr key={`${date}-${url}`} className="table-primary">
            <td>{url}</td>
            <td>{resource.visits}</td>
          </tr>
        );

        totalVisits += resource.visits;

        section.push(resource.referrers.map((referrer, i) => {
          return (
            <tr key={`${date}-${url}-${i}`}>
              <td className="pl-3">{referrer.url}</td>
              <td>{referrer.visits}</td>
            </tr>
          );
        }));
      }

      rows.push(
        <tr key={date} className="table-secondary">
          <th>{date}</th>
          <th>{totalVisits}</th>
        </tr>
      );

      rows = rows.concat(section);
    }
    return rows
  }

}

export default TopReferrersReport
