import React from "react";
import { Button, Container, Nav, Navbar } from "react-bootstrap";
import {
  BsAward,
  BsCardList,
  BsCheck2Square,
  BsDiagram3,
  BsPencilSquare,
  BsWrench,
} from "react-icons/bs";
import FooterItem from "./FooterItem";

export default (props) => {
  return (
    <>
      <Navbar fixed="bottom" bg="light">
        <Container>
          <FooterItem href="/histories" icon={<BsCardList />}>
            一覧
          </FooterItem>
          <FooterItem href="/inventories" icon={<BsCheck2Square />}>
            棚卸し
          </FooterItem>
          <FooterItem href="/summaries" icon={<BsDiagram3 />}>
            集計
          </FooterItem>
          <FooterItem href="/configs" icon={<BsWrench />}>
            設定
          </FooterItem>
          <Nav.Item>
            <Button variant="primary" onClick={props.onClickNewButton}>
              <BsPencilSquare></BsPencilSquare>
            </Button>
          </Nav.Item>
        </Container>
      </Navbar>
    </>
  );
};
