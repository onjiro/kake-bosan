import React, { Component, ComponentProps } from "react";
import RedirectToLogin from "./redirect_to_login";

export default function withAuth(InnerComponent) {
  type Props = { currentUser: any };
  return class Authenticated extends Component<Props> {
    static async getInitialProps(ctx) {
      // TODO ユーザー情報を取得する
      return {
        currentUser: {
          /* TODO */
        },
      };
    }
    constructor(props) {
      super(props);
    }
    render() {
      if (!this.props.currentUser) {
        return <RedirectToLogin />;
      }

      return (
        <InnerComponent {...this.props} currentUser={this.props.currentUser} />
      );
    }
  };
}
