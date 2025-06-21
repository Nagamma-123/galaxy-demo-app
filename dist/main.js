import { h, render } from 'https://unpkg.com/preact@10.5.14?module';

const App = () => {
  return h('main', { class: 'text-center p-4' },
    h('h1', { class: 'text-2xl font-bold text-purple-600' }, '🚀 Galaxy App'),
    h('p', { class: 'text-gray-600' }, 'Serving static content via S3 + Fastly.')
  );
};

render(h(App), document.getElementById('app'));
