import React, { Component } from "react";
import Router from "next/router";

export default class Redirect extends Component<{ page }> {
  componentDidMount(): void {
    Router.replace(this.props.page);
  }
  render() {
    return (
      <>
        <span>{this.props.children}</span>
      </>
    );
  }
}
