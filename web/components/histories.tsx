import { Row, Col, Table } from "react-bootstrap";
import styled from "styled-components";

const ThAmount = styled.th``;
const TdAmount = styled.td``;

export default function Histories(): JSX.Element {
  return (
    <>
      <Table>
        <thead>
          <tr>
            <th>{/* expands */}</th>
            <th>日付</th>
            <th>借方科目</th>
            <ThAmount>借方金額</ThAmount>
            <th>貸方科目</th>
            <ThAmount>貸方金額</ThAmount>
            <th>{/* controls */}</th>
          </tr>
        </thead>
        <tbody>
          {/* 概要 */}
          <tr>
            <td>{/* TODO expandアイコンを入れる */}</td>
            <td>{/* TODO expandアイコンを入れる */}</td>
            <td>{/* TODO expandアイコンを入れる */}</td>
            <TdAmount>{/* TODO expandアイコンを入れる */}</TdAmount>
            <td>{/* TODO expandアイコンを入れる */}</td>
            <TdAmount>{/* TODO expandアイコンを入れる */}</TdAmount>
            <td>{/* TODO expandアイコンを入れる */}</td>
          </tr>
        </tbody>
      </Table>
    </>
  );
}
