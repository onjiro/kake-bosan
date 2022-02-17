import React, { Component, ComponentProps } from "react";
import Redirect from "./redirect";
import { fetchUser } from "../lib/user";

export default function withAuth(InnerComponent) {
  type Props = { currentUser: any };
  return class Authenticated extends Component<Props> {
    static async getInitialProps({ req }) {
      const currentUser = await fetchUser();
      return {
        currentUser,
      };
    }
    constructor(props) {
      super(props);
    }
    render() {
      if (this.props.currentUser?.error) {
        return <Redirect page="/">Signing in...</Redirect>;
      }

      return (
        <InnerComponent {...this.props} currentUser={this.props.currentUser} />
      );
    }
  };
}
