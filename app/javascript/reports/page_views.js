import React from 'react'
import Report from '../report'

class PageViewsReport extends React.Component {

  render() {
    return(
      <Report title="Page Views"
        description = "Number of page views per URL, grouped by day, for the past 5 days."
        dataurl="/api/v1/page_views"
        headers={[ "Url", "Number of Visits" ]}
        rowRenderer={this.renderRows} />
    )
  }

  renderRows(data){
    let rows = new Array

    for (let date in data){
      let section = new Array
      let totalVisits = 0

      section.push(data[date].map((pv, i) => {
        totalVisits += pv.visits
        return(
          <tr key={`${date}-${i}`}>
            <td>{pv.url}</td>
            <td>{pv.visits}</td>
          </tr>
        );
      }));

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

export default PageViewsReport