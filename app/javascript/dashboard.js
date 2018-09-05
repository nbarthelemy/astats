import React from 'react'
import PageViewsReport from "./reports/page_views"
import TopReferrersReport from "./reports/top_referrers"

class Dashboard extends React.Component {

  constructor(props){
    super(props)
    this.state = { report: "page_views" };
  }

  handleTabClick(report){
    this.setState({ report: report })
  }

  render(){
    let report

    if (this.state.report === "top_referrers") {
      report = <TopReferrersReport / >
    } else {
      report = <PageViewsReport / >
    }

    return(
      <div className="container-fluid">
        <div className="row">
          <nav className="col-md-4 col-lg-2 d-none d-md-block bg-light sidebar">
            <div className="sidebar-sticky">
              <h6 className="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                <span>Reports</span>
              </h6>

              <ul className="nav flex-column">
                <li className="nav-item">
                  <a href="#" role="presentation" className={this.state.report === 'page_views' ? 'nav-link active' : 'nav-link'}
                    onClick={() => this.handleTabClick("page_views")}>
                    <span data-feather="list"></span>
                    Page Views
                  </a>
                </li>
                <li className="nav-item">
                  <a href="#" role="presentation" className={this.state.report === 'top_referrers' ?  'nav-link active' : 'nav-link'}
                  onClick={() => this.handleTabClick("top_referrers")}>
                    <span data-feather="share-2"></span>
                    Top Referrers
                  </a>
                </li>
              </ul>
            </div>
          </nav>

          <main role="main" className="col-md-8 ml-sm-auto col-lg-10 px-4">
            {report}
          </main>
        </div>
      </div>
    );
  }
}

export default Dashboard
