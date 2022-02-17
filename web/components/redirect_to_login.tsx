import React, { Component } from "react";
import Router from "next/router";

export default class RedirectToLogin extends Component {
  componentDidMount(): void {
    Router.replace("/");
  }
  render() {
    return (
      <>
        <span>Signing you in...</span>
      </>
    );
  }
}
