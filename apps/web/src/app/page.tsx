// src/app/page.tsx
import {sum} from '@plinks-pw/domain';
import {type FC} from 'react';

const IndexPage: FC = () => {
  return <div>Hello World! {sum(2, 2)}</div>;
};

export default IndexPage;